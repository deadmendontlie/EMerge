import React from 'react';
import { Switch, Route, Redirect } from 'react-router-dom';

import './App.css';

import HomePage from './pages/homepage/homepage.component';
import SignInPage from './pages/sign-in/sign-in-page.component';
import Header from './components/header/header.component';

import { auth, createUserProfileDocument, } from './firebase/firebase.util';

class App extends React.Component {
  constructor() {
    super();

    this.state = {
      currentUser: null
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
              console.log(this.state);
                });
              });
             
          }
          else {
            this.setState({currentUser: userAuth});
          }
    });
  
  }
  
  // this will close the subscription
  componentWillUnmount() {
    this.unsubscribeFromAuth();
  }



  render() {
    return(
      <div>
       <Header currentUser={this.state.currentUser}/>
        <Switch>
          <Route exact path='/' 
              render={() => this.state.currentUser ? (<HomePage></HomePage>) : (<Redirect to='/signin'/>)}/>
          <Route exact path='/signin' 
              render={() => this.state.currentUser ? (<Redirect to='/'/>) : (<SignInPage/>)}/>
        </Switch>
      </div>

    )
  }
  
  
}

export default App;
