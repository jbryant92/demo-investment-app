import gql from "graphql-tag";

export default gql`
  mutation createInvestment($campaignId: Int!, $amount: Float!) {
    createInvestment(campaignId: $campaignId, amount: $amount) {
      id
    }
  }
`;
