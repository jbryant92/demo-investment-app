import React, { Component } from 'react';
import {
  Query
} from 'react-apollo';
import {
  Segment,
  Dimmer,
  Loader,
  Container,
  Header,
  Button,
  Card,
  Icon
} from 'semantic-ui-react';
import { Row }  from 'reactstrap';

import query from '../../queries/getInvestment';
import CampaignCard from '../CampaignCard'
import '../../App.css'

class Investment extends Component {
  render() {
    const { id } = this.props.match.params

    return (
      <Query
        query={query}
        variables={{ id }}
      >
        {({ loading, error, data }) => {
          if (loading) return(
            <Dimmer active inverted>
              <Loader size='large'>Loading</Loader>
            </Dimmer>
          );

          if (error) return <p>{error}</p>;

          const { campaign, amount } = data.investment;
          return (
            <Container textAlign='center'>
              <Header as='h2' icon textAlign='center'>
                <Icon name='trophy' circular />
                <Header.Content>Investment Successful!</Header.Content>
                 <Header.Subheader>Congratulations! You invested £{ amount } in { campaign.name }.</Header.Subheader>
              </Header>

              <Card.Group centered={ true }>
                <CampaignCard campaign={ campaign } clickable={ false }/>
              </Card.Group>

              <Container>
                <Row className='input-row'>
                  <Button positive href="/">
                    Continue investing
                    <Icon name='right arrow'/>
                  </Button>
                </Row>

              </Container>
            </Container>
          );
        }}
      </Query>
    )
  }
}

export default Investment;
