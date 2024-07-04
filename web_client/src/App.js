import React from 'react';
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import Register from './Pages/Register';
import Login from './Pages/Login';
import Account from './Pages/Account';

function App() {
  return (
    <Router>
      <div className="App">
        <Routes>
          <Route path="/register" element={<Register />} />
          <Route path="/account" element={<Account />} />
          <Route path="/*" element={<Login />} />
        </Routes>
      </div>
    </Router>
  );
}

export default App;
