import React from 'react';
import { Switch, Route } from 'react-router-dom';

import './App.css';

import HomePage from './pages/homepage/homepage.component';
import SignInAndSignUpPage from './pages/sign-in-and-sign-up/sign-in-and-sign-up.component';
import Header from './components/header/header.component';


const SignInPage = () => (
  <div>
    <h1>Sign In Bro WTF!!!!!</h1>
  </div>
)

class App extends React.Component {
  
  render() {
    return(
      <div>
       <Header />
        <Switch>
          <Route exact path='/' component={HomePage} />
          <Route path='/signin' component={SignInAndSignUpPage} />
        </Switch>
      </div>

    )
  }
  
}

export default App;
