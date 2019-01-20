import React from 'react';
import ReactDOM from 'react-dom';
import App from './index';
import enzymeToJson from 'enzyme-to-json'
import { shallow } from 'enzyme'

it('renders without crashing', () => {
  const instance = shallow(
        <App />
    )
    expect(enzymeToJson(instance)).toMatchSnapshot()
});
