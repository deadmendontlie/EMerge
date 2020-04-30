import React from 'react';

import './sign-in.styles.scss';

import FormInput from '../form-input/form-input.component';
import CustomButton from '../custom-button/custom-button.component';

import { auth } from '../../firebase/firebase.util';

class SignIn extends React.Component{
    constructor(props) {
        super(props);
    

    this.state = {
        email: '',
        password: ''
    }
}

handleSubmit = async event => {
    event.preventDefault();

    // setting our variables state
    const { email, password } = this.state;
    
    // here we are checking for sign in
    // if any issue report thorugh console.
    try {
        await auth.signInWithEmailAndPassword(email, password);
        this.setState({email: '', password: ''});
    } catch (error) {
        console.log(error);
    }
}
// here we set the name variables
handleChange = event => {
    const { value, name } = event.target;

    this.setState({ [name]: value })
}

render () {
    // below is the personalized Form input for the sign in user
    // this is what the user will use when signing into our website.
    return(
        <div className='sign-in'>
            <h2>Welcome to Emerge</h2>
            <span>Sign in with your email and password</span>

            <form onSubmit={this.handleSubmit}>
                <FormInput 
                name="email" 
                type="email" 
                handleChange={this.handleChange} 
                value={this.state.email}
                label='email' 
                required/>
                <FormInput 
                name="password" 
                type="password" 
                value={this.state.password} 
                handleChange={this.handleChange}
                label='password'
                required/>
                <div className='buttons'>
                <CustomButton type='submit'> Sign In </CustomButton>
                </div>
            </form>
        </div>
    );
}
}

export default SignIn;