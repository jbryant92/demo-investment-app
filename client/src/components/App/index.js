import React from 'react';
import {
  BrowserRouter as Router,
  Route,
  Switch,
  Redirect
} from 'react-router-dom';
import { Header } from 'semantic-ui-react';

import Campaigns from '../Campaigns';
import Campaign from '../Campaign';
import Investment from '../Investment';
import '../../App.css'

const App = () => (
  <div>
    <Header as='h1' className='app-header'>Demo investment app</Header>
    <Router>
      <Switch>
        <Route exact path="/" render={() => (
            <Redirect to="/campaigns"/>
        )}/>
        <Route exact path='/campaigns' component={ Campaigns } />
        <Route path='/campaigns/:id' component={ Campaign } />
        <Route path='/investments/:id' component={ Investment } />
        <Route render={() => <div>404</div>} />
      </Switch>
    </Router>
  </div>
)

export default App;