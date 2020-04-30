import React from 'react';

import FormInput from '../form-input/form-input.component';
import CustomButton from '../custom-button/custom-button.component';

import { auth, createUserProfileDocument } from '../../firebase/firebase.util';

import './sign-up.styles.scss';

function refreshPage() {
    window.location.reload(false);
  }

class SignUp extends React.Component {
    constructor() {
        super();

        this.state = {
            displayName: '',
            email: '',
            password: '',
            confirmPassword: ''
        }
    }
    // preventing the default submit method
    handleSubmit = async event => {
        event.preventDefault();

        // getting props from previous components and updating
        // our current variables state
        const {displayName, email, password, confirmPassword} = this.state;

        // if passwords do not match return from the whole function
        // checking password in short sence
        if(password !== confirmPassword) {
            alert("passwords don't match");
            return;
        }

        try {
            // here we are creating a user
            const { user } = await auth.createUserWithEmailAndPassword(email, password);

            await createUserProfileDocument(user, {displayName});
            // this will clear our form
            this.setState({
            displayName: '',
            email: '',
            password: '',
            confirmPassword: ''
            });
        } catch (error) {
            console.error(error);
        }
    };
    // another handle change in which we also set the name
    handleChange = event => {
        const { name, value } = event.target;

        this.setState({[name]: value});
    };

    render () {
        // below is the personalized sign up form which the user will use to sign up
        const {displayName, email, password, confirmPassword} = this.state;
        return(
            <div className='sign-up'>
                <h2 className='title'>I do not have an account</h2>
                <span>Sign up with your email and password</span>
                <form className='sign-up-form' onSubmit={this.handleSubmit}>
                    <FormInput
                        type='text'
                        name='displayName'
                        value={displayName}
                        onChange={this.handleChange}
                        label='Display Name'
                        required
                    />
                        <FormInput
                        type='email'
                        name='email'
                        value={email}
                        onChange={this.handleChange}
                        label='Email'
                        required
                    />
                        <FormInput
                        type='password'
                        name='password'
                        value={password}
                        onChange={this.handleChange}
                        label='Password'
                        required
                    />
                        <FormInput
                        type='password'
                        name='confirmPassword'
                        value={confirmPassword}
                        onChange={this.handleChange}
                        label='Confirm Password'
                        required
                    />
                    <CustomButton type='submit' onClick={() => {refreshPage()}}>SIGN UP</CustomButton>
                </form>

            </div>
        )
    }
}

export default SignUp;