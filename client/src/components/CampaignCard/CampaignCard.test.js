import React from 'react';
import ReactDOM from 'react-dom';
import CampaignCard from './index';
import enzymeToJson from 'enzyme-to-json'
import { shallow } from 'enzyme'

it('renders without crashing', () => {
  const instance = shallow(
        <CampaignCard campaign={{ country: {name: 'foo' }}} />
    )
    expect(enzymeToJson(instance)).toMatchSnapshot()
});
