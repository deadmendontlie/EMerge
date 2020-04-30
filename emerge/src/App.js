import React from 'react';
import { Switch, Route, Redirect } from 'react-router-dom';
import axios from 'axios';

import './App.css';
// necesarry imports
import HomePage from './pages/homepage/homepage.component';
import SignInPage from './pages/sign-in/sign-in-page.component';
import Header from './components/header/header.component';
import AdminPage from './pages/adminpage/adminpage.component';
import SignUp from './components/sign-up/sign-up.component';

import { auth, createUserProfileDocument, } from './firebase/firebase.util';
import { scrollToTop } from 'react-scroll/modules/mixins/animate-scroll';



class App extends React.Component {
  constructor() {
    super();
    // state variables can be passed to props
    this.state = {
      currentUser: null,
      UserName: null,
      email: null,
      municipality_id: null,
    }
  }

  unsubscribeFromAuth = null;
// when page is mounted the below code gets executed
  componentDidMount() {
    this.unsubscribeFromAuth = auth.onAuthStateChanged(async userAuth => {
      
      if(userAuth) {
          // if user gets authenticated
            const userRef = createUserProfileDocument(userAuth);
          // we then pull his info from the database
            (await userRef).onSnapshot(snapShot => {
              this.setState({
                  currentUser: {
                  id: snapShot.id,
                  ...snapShot.data()
                  }
                }, () => {
                   // we set the username and email variables hers
                   // which will later be used in different components

                this.setState({UserName: this.state.currentUser.displayName});
                this.setState({email: this.state.currentUser.email});
                
                });
              });
             
          }
          else {
            // here we set the state for currentuser and 
            // AdminOn is just to check and see if the 
            // user logged in is the admin so we can reroute him to a different pate
            this.setState({currentUser: userAuth});
            this.setState({AdminOn: null})
          }
    });

    // passing the email to the database and getting the municipality id from
    // the database, then setting the state
    // of our municipality id variable
    axios.post('http://18.212.156.43/get_muni_by_email', {
			email: this.state.email
		})
		.then((response) => {
			console.log(response.data);
			const municipality_id = response.data.municipality_id;
            this.setState({ municipality_id })
		}, (error) => {
			console.log(error);
		})
  }
  
  // this will close the subscription
  componentWillUnmount() {
    this.unsubscribeFromAuth();
  }


  render() {
    // the portion below is our Websites structure, you can also se the 
    // createad routes and how rerouting is happening, you can also so that
    // we are checking which user is logged in order to redirect them to the
    // right pages
    return(
      <div>
       <Header currentUser={this.state.currentUser} UserName={this.state.UserName}/>
        <Switch>
          <Route exact path='/' 
              render={() => this.state.UserName==='Admin' ? (<Redirect to='/admin'/>) 
              : this.state.currentUser ? (<HomePage municipality_id={this.state.municipality_id}></HomePage>)
              :(<Redirect to='/signin'/>)}/>
          <Route exact path='/signin' 
              render={() => this.state.currentUser ? (<Redirect to='/'/>) : (<SignInPage/>)}/>
          <Route exact path='/signup' 
              render={() => this.state.currentUser ? (<SignUp></SignUp>) : (<Redirect to='/'/>)}/>
          <Route exact path='/admin' 
              render={() => 
                this.state.currentUser ? (<AdminPage></AdminPage>) : (<Redirect to='/signin'/>)}/>
        </Switch>
      </div>

    )
  }
  
}



export default App;

