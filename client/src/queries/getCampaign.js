import gql from 'graphql-tag';

export default gql`
  query getCampaign($id: ID!) {
    campaign(id: $id) {
      id
      name
      sector
      imageUrl
      country {
        name
      }
      targetAmount
      fundedAmount
      percentageComplete
      numberOfInvestors
    }
  }
`;
