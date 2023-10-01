importScripts("https://www.gstatic.com/firebasejs/9.6.10/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/9.6.10/firebase-messaging-compat.js");

// todo Copy/paste firebaseConfig from Firebase Console
// For Firebase JS SDK v7.20.0 and later, measurementId is optional

const firebaseConfig = {

    apiKey: "AIzaSyAltgo76rrNgodFpubCBhgvooalQEIhiHw",
  
    authDomain: "swipeswap-b1544.firebaseapp.com",
  
    projectId: "swipeswap-b1544",
  
    storageBucket: "swipeswap-b1544.appspot.com",
  
    messagingSenderId: "142866795354",
  
    appId: "1:142866795354:web:e51063e064942cf7cd0163",
  
    measurementId: "G-P5GBS2ZS1H"
  
  };

firebase.initializeApp(firebaseConfig);
const messaging = firebase.messaging();

// Set up background message handler
messaging.onBackgroundMessage((message) => {
  console.log("onBackgroundMessage", message);
 });
 