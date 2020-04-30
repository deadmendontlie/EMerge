import React from 'react';
import * as scroll from 'react-scroll';
import { auth } from '../../firebase/firebase.util';
import { Link } from 'react-router-dom';
import { ReactComponent as Logo } from '../../assets/untitled.svg';

import './header.styles.scss';


// a refresh function that refreshes the window
function refreshPage() {
    window.location.reload(false);
  }

  // this is our headear component below we do a lot of checking
  // on the users state, if the user is logged in then
  // the snowball effect is triggered. The below code will
  // check who is the current user and will display only
  // the necessary components based on who the user is.
  // For example if admin is logged in he will have access
  // to the Sign up functionality in the headear
  // while a regular user such as John will not have
  // access to that component in the header

const Header = ({ currentUser, UserName}) => (
    <div className='header'>
        { currentUser ?
        <Link className='logo-container' to='/'>
            <Logo className='logo' />
        </Link>
        :
        <div className='logo-container'>
            <Logo className='logo' />
        </div>
        }
        <div className='options'>
            {
            currentUser ?
            <div className='option'>Welcome <b>{currentUser.displayName}</b></div>
            :
            <div></div>
            }
            {
            currentUser ?
            <scroll.Link className='option'activeClass="active"
                to="Homepage"
                spy={true}
                smooth={true}
                hashSpy={true}
                offset={-100}
                duration={500}
                delay={250}
                isDynamic={true}
                ignoreCancelEvents={false}>Scroll to Top</scroll.Link>
                :
                <div></div>
            }
            <div className='option' id="google_translate_element"></div>
            {
                UserName==='Admin' | currentUser ?
                <Link className='option' to='/signup'>Sign Up</Link>
                :
                null
            }
            {
                currentUser ?
                    <div className='option' onClick={() => {auth.signOut(); refreshPage()}} >Sign Out</div>
                    :
                    <Link className='option' to='/signin'>Sign In</Link>
            }
        </div>
    </div>
)

export default Header;