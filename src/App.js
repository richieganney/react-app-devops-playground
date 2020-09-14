import React from 'react';
import './App.css';
import NavBar from './components/NavBar.js'
import FactGenerator from './components/FactGenerator.js'
import BackgroundImageRefresh from './components/BackgroundImageRefresh.js';

function App() {
  return (
    <div className="App">
        <NavBar></NavBar>
        <FactGenerator></FactGenerator>
        <BackgroundImageRefresh></BackgroundImageRefresh>
    </div>
  );
}

export default App;
