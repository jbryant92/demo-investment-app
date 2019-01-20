import React, { Component } from 'react';
import {
  Card,
  Image,
  Icon,
  Progress
} from 'semantic-ui-react';
import { Link } from 'react-router-dom';

class CampaignCard extends Component {
  render() {
    const {
      id,
      imageUrl,
      name,
      sector,
      country,
      targetAmount,
      fundedAmount,
      percentageComplete,
      numberOfInvestors
    } = this.props.campaign;

    const clickable = this.props.clickable
    const inverstorString = numberOfInvestors > 1 ? 'people have' : 'person has'
    return (
      <Card key={ id } as={ clickable ? Link : null } to={ clickable ? `/campaigns/${id}` : null}>
        <Image src={ imageUrl } />
        <Card.Content>
          <Card.Header>{ name }</Card.Header>
          <Card.Meta>{ sector }</Card.Meta>
          <Card.Meta>{ country.name }</Card.Meta>
          <Card.Description>Investment sought: £{ targetAmount }</Card.Description>
          <Card.Description>Investment already funded: £{ fundedAmount }</Card.Description>
        </Card.Content>
        <Card.Content extra>
          <Progress
            percent={ percentageComplete }
            size='small'
            active
            success={ percentageComplete >= 100.0 }
            color='blue'
          >
            { percentageComplete }% complete
          </Progress>
        </Card.Content>
        <Card.Content extra>
          <Icon name='user' />
          { numberOfInvestors } { inverstorString } invested
        </Card.Content>
      </Card>
    )
  }
}

export default CampaignCard;
