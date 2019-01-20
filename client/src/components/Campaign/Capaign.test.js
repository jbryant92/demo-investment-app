import React from 'react';
import ReactDOM from 'react-dom';
import Campaign from './index';
import enzymeToJson from 'enzyme-to-json'
import { shallow } from 'enzyme'

it('renders without crashing', () => {
  const instance = shallow(
        <Campaign match={{params: {id: 1}}} />
    )
    expect(enzymeToJson(instance)).toMatchSnapshot()
});
