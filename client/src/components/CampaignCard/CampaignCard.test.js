import React from 'react';
import ReactDOM from 'react-dom';
import CampaignCard from './index';
import enzymeToJson from 'enzyme-to-json'
import { shallow } from 'enzyme'

it('renders without crashing', () => {
  const mockCampaign = {
    id: 1,
    name: 'foo',
    sector: 'bar',
    targetAmount: 100,
    fundedAmount: 50,
    percentageComplete: 50,
    numberOfInvestors: 2,
    country: {
      name: 'uk'
    }
  }
  const instance = shallow(
        <CampaignCard campaign={ mockCampaign } />
    )
    expect(enzymeToJson(instance)).toMatchSnapshot()
});
