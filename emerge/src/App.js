import React from 'react';
import { Switch, Route } from 'react-router-dom';

import './App.css';

import HomePage from './pages/homepage/homepage.component';
import SignInPage from './pages/sign-in/sign-in.component';
import Header from './components/header/header.component';


class App extends React.Component {
  
  render() {
    return(
      <div>
       <Header />
        <Switch>
          <Route exact path='/' component={HomePage} />
          <Route path='/signin' component={SignInPage} />
        </Switch>
      </div>

    )
  }
  
}

export default App;
