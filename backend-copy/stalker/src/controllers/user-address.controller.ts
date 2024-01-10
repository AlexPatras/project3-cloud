import {
  Count,
  CountSchema,
  Filter,
  repository,
  Where,
} from '@loopback/repository';
import {
  del,
  get,
  getModelSchemaRef,
  getWhereSchemaFor,
  param,
  patch,
  post,
  requestBody,
} from '@loopback/rest';
import {
  Address,
  User,
} from '../models';
import {MyUserRepository} from '../repositories';

export class UserAddressController {
  constructor(
    @repository(MyUserRepository) protected userRepository: MyUserRepository,
  ) { }

  @get('/users/{id}/addresses', {
    responses: {
      '200': {
        description: 'Array of User has many Address',
        content: {
          'application/json': {
            schema: {type: 'array', items: getModelSchemaRef(Address)},
          },
        },
      },
    },
  })
  async find(
    @param.path.number('id') id: number,
    @param.query.object('filter') filter?: Filter<Address>,
  ): Promise<Address[]> {
    return this.userRepository.addresses(id).find(filter);
  }

  @post('/users/{id}/addresses', {
    responses: {
      '200': {
        description: 'User model instance',
        content: {'application/json': {schema: getModelSchemaRef(Address)}},
      },
    },
  })
  async create(
    @param.path.number('id') id: typeof User.prototype.id,
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(Address, {
            title: 'NewAddressInUser',
            exclude: ['id'],
            optional: ['userId']
          }),
        },
      },
    }) address: Omit<Address, 'id'>,
  ): Promise<Address> {
    return this.userRepository.addresses(id).create(address);
  }

  @patch('/users/{id}/addresses', {
    responses: {
      '200': {
        description: 'User.Address PATCH success count',
        content: {'application/json': {schema: CountSchema}},
      },
    },
  })
  async patch(
    @param.path.number('id') id: number,
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(Address, {partial: true}),
        },
      },
    })
    address: Partial<Address>,
    @param.query.object('where', getWhereSchemaFor(Address)) where?: Where<Address>,
  ): Promise<Count> {
    return this.userRepository.addresses(id).patch(address, where);
  }

  @del('/users/{id}/addresses', {
    responses: {
      '200': {
        description: 'User.Address DELETE success count',
        content: {'application/json': {schema: CountSchema}},
      },
    },
  })
  async delete(
    @param.path.number('id') id: number,
    @param.query.object('where', getWhereSchemaFor(Address)) where?: Where<Address>,
  ): Promise<Count> {
    return this.userRepository.addresses(id).delete(where);
  }
}
