import React, { Component } from 'react';
import { Query } from 'react-apollo';
import {
  Loader,
  Segment,
  Dimmer,
  Card,
  Container
} from 'semantic-ui-react';

import query from '../../queries/campaigns'
import CampaignCard from '../CampaignCard'

class Campaigns extends Component {
  render() {
    return (
      <Query
        query={ query }
      >
        {({ loading, error, data }) => {
          if (loading) return(
            <Dimmer active inverted>
              <Loader size='large'>Loading</Loader>
            </Dimmer>
          );
          if (error) return <p>Error</p>;

          return (
            <Container>
              <Card.Group centered>
                { data.campaigns.map((campaign) => (
                <CampaignCard key={ campaign.id } campaign={ campaign } clickable={ true }/>
                ))}
              </Card.Group>
            </Container>
          );
        }}
      </Query>
    )
  }
}
export default Campaigns;