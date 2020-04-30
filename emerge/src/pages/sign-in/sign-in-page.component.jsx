import React from 'react';

import SignIn from '../../components/sign-in/sign-in.component';

import './sign-in-page.styles.scss';

// Calling my SigIn Page Component
const SignInPage = () =>(
    <div className='sign-in'>
        <SignIn/>
    </div>
);

export default SignInPage;