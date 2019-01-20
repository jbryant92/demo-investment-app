import React from 'react';
import ReactDOM from 'react-dom';
import Investment from './index';
import enzymeToJson from 'enzyme-to-json'
import { shallow } from 'enzyme'

it('renders without crashing', () => {
  const instance = shallow(
        <Investment match={{params: {id: 1}}} />
    )
    expect(enzymeToJson(instance)).toMatchSnapshot()
});
