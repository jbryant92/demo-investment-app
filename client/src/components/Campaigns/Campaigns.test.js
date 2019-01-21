import React from 'react';
import ReactDOM from 'react-dom';
import Campaigns from './index';
import enzymeToJson from 'enzyme-to-json'
import { shallow } from 'enzyme'

it('renders without crashing', () => {
  const instance = shallow(
        <Campaigns location={ { search: '?page=1' } }/>
    )
    expect(enzymeToJson(instance)).toMatchSnapshot()
});
