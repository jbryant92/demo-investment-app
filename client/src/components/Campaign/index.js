import React, { Component } from 'react';
import {
  Query,
  Mutation
} from 'react-apollo';
import {
  Dimmer,
  Loader,
  Container,
  Button,
  Input,
  Card,
  Icon
} from 'semantic-ui-react';
import { Row }  from 'reactstrap';
import PropTypes from 'prop-types'

import query from '../../queries/getCampaign';
import createInvestment from '../../mutations/createInvestment';
import CampaignCard from '../CampaignCard'
import '../../App.css'

class Campaign extends Component {
  state = { amount: '', errors: null, alternatives: null }

  handleAmountChange = (e) => {
    const value = e.target.value
    this.setState( { amount: value } )
  }

  handleSubmit = (createInvestment, data) => {
    this.setState( { errors: null} )
    const { amount } = this.state

    if(!amount || parseInt(amount) < 1) {
      this.setState( { errors: 'You must enter an amount greater than 0' } )
      return
    }
    const { id } = this.props.match.params

    createInvestment({ variables: { campaignId: parseInt(id), amount: parseFloat(amount) } }).then(res => {
      this.props.history.push(`/investments/${res.data.createInvestment.id}` )
    }).catch(e => {
      if (e.graphQLErrors) {
        this.setState( { errors: e.graphQLErrors[0].message, alternatives: e.graphQLErrors[0].alternatives } )
      }
   })
  }

  handleButtonClick = (value) => {
    this.setState({
      amount: `${value}`,
      errors: null,
      alternatives: null
    })
  }

  render() {
    const { id } = this.props.match.params

    return (
      <Query
        query={ query }
        variables={{ id }}
      >

        {({ loading, error, data }) => {
          if (loading) return(
            <Dimmer active inverted>
              <Loader size='large'>Loading</Loader>
            </Dimmer>
          );

          if (error) return <p>{ error }</p>;

          const { campaign } = data;

          return (
            <Container textAlign='center'>
              <Card.Group centered={ true }>
                <CampaignCard campaign={ campaign } clickable={ false }/>
              </Card.Group>

              <Container>
                <Row className='input-row'>
                  <Input
                    iconPosition='left'
                    type='number'
                    placeholder='Enter Amount'
                    value={ this.state.amount }
                    onChange={ this.handleAmountChange }
                  >
                    <Icon name='pound' />
                    <input />
                  </Input>
                </Row>

                <Row className='input-row'>
                  <Button onClick={this.props.history.goBack}>
                    <Icon name='left arrow'/>
                    Back
                  </Button>
                  <Mutation mutation={ createInvestment }>
                    {(createInvestment, { data }) => (
                      <Button positive onClick={ () => this.handleSubmit(createInvestment, data) }>
                        Invest
                        <Icon name='right arrow'/>
                      </Button>
                    )}
                  </Mutation>
                </Row>

                {
                  this.state.errors && <Card.Group centered={ true }>
                    <Card color='red'>
                      <Card.Content>
                        <Card.Description>
                          { this.state.errors }
                        </Card.Description>
                      </Card.Content>

                      {
                        this.state.alternatives && <Card.Content extra>
                          <div className='ui two buttons'>
                            <Button basic color='green' onClick={ () => this.handleButtonClick(this.state.alternatives[0])}>
                              £{ this.state.alternatives[0] }
                            </Button>
                            <Button basic color='green' onClick={ () => this.handleButtonClick(this.state.alternatives[1])}>
                              £{ this.state.alternatives[1] }
                            </Button>
                          </div>
                        </Card.Content>
                      }

                    </Card>
                  </Card.Group>
                }

              </Container>
            </Container>
          );
        }}
      </Query>
    )
  }
}

Campaign.propTypes = {
  match: PropTypes.shape({
    params: PropTypes.shape({
      id: PropTypes.string.isRequired,
    }),
  }),
  history: PropTypes.object.isRequired
};

export default Campaign;
