import React, { Component } from 'react';
import { Query } from 'react-apollo';
import {
  Loader,
  Dimmer,
  Card,
  Container,
  Pagination
} from 'semantic-ui-react';
import queryString from 'query-string'
import PropTypes from 'prop-types'

import query from '../../queries/getCampaigns'
import CampaignCard from '../CampaignCard'
import '../../App.css'

class Campaigns extends Component {
  handlePaginationChange = (e, { activePage }) => {
    this.props.history.push('/campaigns?page=' + activePage)
  }

  render() {
    const page = parseInt(queryString.parse(this.props.location.search).page || 1)

    return (
      <Query
        query={ query }
        variables={{ page }}
      >
        {({ loading, error, data }) => {

          if (loading) return(
            <Dimmer active inverted>
              <Loader size='large'>Loading</Loader>
            </Dimmer>
          );
          if (error) return <p>Error</p>;

          const {
            campaigns,
            totalPages
          } = data.paginatedCampaigns

          return (
            <Container>
              <Card.Group centered>
                { campaigns.map((campaign) => (
                <CampaignCard key={ campaign.id } campaign={ campaign } clickable={ true }/>
                ))}
              </Card.Group>

              <Container textAlign='right' className='pagination-controls'>
                <Pagination
                  boundaryRange={0}
                  defaultActivePage={ page }
                  ellipsisItem={null}
                  firstItem={null}
                  lastItem={null}
                  siblingRange={1}
                  totalPages={totalPages}
                  onPageChange={ this.handlePaginationChange.bind(this) }
                />
              </Container>
            </Container>
          );
        }}
      </Query>
    )
  }
}

Campaigns.propTypes = {
  location: PropTypes.shape({
    search: PropTypes.string,
  })
}

export default Campaigns;
