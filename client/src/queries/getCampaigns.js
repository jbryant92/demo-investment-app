import gql from 'graphql-tag';

export default gql`
  query getCampaigns($page: Int!) {
    paginatedCampaigns(page: $page) {
      campaigns{
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
      totalPages
    }
  }
`;
