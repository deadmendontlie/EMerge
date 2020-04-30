import React from 'react';

import './custom-button.styles.scss';

// this is a custom button createad for ease of
// use, which helps us in not having to styles
// every button we create from now on
const CustomButton = ({ children, ...otherProps }) => 
(
    <button className='custom-button' {...otherProps}> 
        {children}
    </button>
);

export default CustomButton;