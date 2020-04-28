import React from 'react';
import { Switch, Route, Redirect } from 'react-router-dom';
import axios from 'axios';

import './App.css';

import HomePage from './pages/homepage/homepage.component';
import SignInPage from './pages/sign-in/sign-in-page.component';
import Header from './components/header/header.component';
import AdminPage from './pages/adminpage/adminpage.component';
import SignUp from './components/sign-up/sign-up.component';

import { auth, createUserProfileDocument, } from './firebase/firebase.util';



class App extends React.Component {
  constructor() {
    super();

    this.state = {
      currentUser: null,
      UserName: null,
      email: null,
      municipality_id: null
    }
  }

  unsubscribeFromAuth = null;

  componentDidMount() {
    this.unsubscribeFromAuth = auth.onAuthStateChanged(async userAuth => {
      
      if(userAuth) {
            const userRef = createUserProfileDocument(userAuth);
      
            (await userRef).onSnapshot(snapShot => {
              this.setState({
                  currentUser: {
                  id: snapShot.id,
                  ...snapShot.data()
                  }
                }, () => {
                   // used to see who logged in

                this.setState({UserName: this.state.currentUser.displayName});
                this.setState({email: this.state.currentUser.email});
                
                
                //this.state.AdminOn='something';
              //this.state.AdminOn=null;
            
                   //console.log(this.state.currentUser.email);
                   //console.log(this.state.email);
                });
              });
             
          }
          else {
            this.setState({currentUser: userAuth});
            this.setState({AdminOn: null})
          }
    });
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
          <Route exact path='/signup' component={SignUp}/>
          <Route exact path='/admin' 
              render={() => 
                this.state.currentUser ? (<AdminPage></AdminPage>) : (<Redirect to='/signin'/>)}/>
          
        </Switch>
      </div>

    )
  }
  
  
}

export default App;

