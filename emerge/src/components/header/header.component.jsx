import React from 'react';
import { Link } from 'react-router-dom';

import { auth } from '../../firebase/firebase.util';

import { ReactComponent as Logo } from '../../assets/untitled.svg';

import './header.styles.scss';

const Header = ({ currentUser }) => (
    <div className='header'>
        <Link className='logo-container' to ='/signin'>
            <Logo className='logo' />
        </Link>
        <div className='options'>
            {
             currentUser ?
             <div className='option' onClick={() => auth.signOut()}>SIGN OUT</div>
             :
             <Link className='option' to='/signin'>Sign In</Link>
            }  
        </div>
    </div>
)

export default Header;