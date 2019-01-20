import gql from 'graphql-tag';

export default gql`
  query getInvestment($id: ID!) {
    investment(id: $id){
      amount
      campaign{
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
  }
`;
