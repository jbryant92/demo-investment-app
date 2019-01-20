import gql from 'graphql-tag';

export default gql`
  {
    campaigns {
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
