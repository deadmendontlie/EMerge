import firebase from 'firebase/app';
import 'firebase/firestore';
import 'firebase/auth';

const config = {
    apiKey: "AIzaSyC8eK_le1oQzFsqcbjEhpxB_cNlpJdi7og",
    authDomain: "emerge-cd9a6.firebaseapp.com",
    databaseURL: "https://emerge-cd9a6.firebaseio.com",
    projectId: "emerge-cd9a6",
    storageBucket: "emerge-cd9a6.appspot.com",
    messagingSenderId: "443193739876",
    appId: "1:443193739876:web:47bf6456d63cfb468ced71",
    measurementId: "G-4QVS1H1D5K"
};

firebase.initializeApp(config);

export const createUserProfileDocument =  async (userAuth, additionalData) => {
    // if the user object doesn't exist
    // we want to exit from this function
    if(!userAuth) return;
    
    const userRef = firestore.doc(`users/${userAuth.uid}`);

    const snapShot = await userRef.get();

    // if the snap shot does not have any data
    // create a new user using data from our userAuth
    // object
    if(!snapShot.exists) {
        const { displayName, email } = userAuth;
        const createdAt = new Date();

        try {
            await userRef.set({
                displayName, 
                email,
                createdAt,
                ...additionalData
            })
        } catch(error) {
            console.log('error creating user', error.message);
        }
    }
    
    return userRef;
  };

export const auth = firebase.auth();
export const firestore = firebase.firestore();

const provider = new firebase.auth.GoogleAuthProvider();
provider.setCustomParameters({ prompt: 'select_account' });


export default firebase;