import React from 'react';
import ReactDOM from 'react-dom';
import Campaign from './index';
import enzymeToJson from 'enzyme-to-json'
import { shallow } from 'enzyme'
import { createMemoryHistory } from 'history'

it('renders without crashing', () => {
  const history = createMemoryHistory('/campaign')
  const instance = shallow(
        <Campaign match={ { params: { id: '1'} } } history={history}/>
    )
    expect(enzymeToJson(instance)).toMatchSnapshot()
});
