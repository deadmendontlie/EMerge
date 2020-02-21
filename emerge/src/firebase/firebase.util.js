// import firebase from 'firebase/app';
// import 'firebase/firestore';
// import 'firebase/auth';

// const config = {
//     apiKey: "AIzaSyDL5tVEP1vs1g890gaL-B0mbSGs1__SrVs",
//     authDomain: "emerge-67e04.firebaseapp.com",
//     databaseURL: "https://emerge-67e04.firebaseio.com",
//     projectId: "emerge-67e04",
//     storageBucket: "emerge-67e04.appspot.com",
//     messagingSenderId: "977102204802",
//     appId: "1:977102204802:web:0857d9e0e37dcd2500e99b",
//     measurementId: "G-QLWP3V7FMM"
// };

// export const createUserProfileDocument = async (userAuth, additionalData) => {
//     if(!userAuth) return;

//     const userRef = firestore.doc(`users/${userAuth.uid}`)

//     const snapShot = await userRef.get();

//     if(!snapShot.exists) {
//         const { displayName, email } = userAuth;
//         const createdAt = new Date();

//         try {
//             await userRef.set({
//                 displayName, 
//                 email,
//                 createdAt,
//                 ...additionalData
//             })
//         } catch(error) {
//             console.log('error creating user', error.message);
//         }
//     }
// }

// firebase.initializeApp(config);

//   export const auth = firebase.auth();
//   export const firestore = firebase.firestore();

//   const provider = new firebase.auth.GoogleAuthProvider();
//   provider.setCustomParameters({ prompt: 'select_account' });
//   export const signInWithGoogle =  () => auth.signInWithPopup(provider);

//   export default firebase;