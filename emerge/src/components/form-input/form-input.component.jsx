import React from 'react';

import './form-input.styles.scss';

// this form input was specifically createad 
// to accomodate for the sign in and sign up components
// instead of using the regular one I createad
// one that best suits our needs.
const FormInput = ({ handleChange, label, ...otherProps}) =>
(
    <div className="group">
        <input className='form-input' onChange={handleChange} {...otherProps}/>
        {
            label ?
            (<label className={`${
                otherProps.value.length ? 'shrink' : ''
                } form-input-label`}
                >
                {label}
            </label>)
            :null
        }
    </div>
)

export default FormInput;