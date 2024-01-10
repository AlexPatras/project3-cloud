import {
  repository,
} from '@loopback/repository';
import {
  param,
  get,
  getModelSchemaRef,
} from '@loopback/rest';
import {
  Address,
  User,
} from '../models';
import {AddressRepository} from '../repositories';

export class AddressUserController {
  constructor(
    @repository(AddressRepository)
    public addressRepository: AddressRepository,
  ) { }

  @get('/addresses/{id}/user', {
    responses: {
      '200': {
        description: 'User belonging to Address',
        content: {
          'application/json': {
            schema: getModelSchemaRef(User),
          },
        },
      },
    },
  })
  async getUser(
    @param.path.number('id') id: typeof Address.prototype.id,
  ): Promise<User> {
    return this.addressRepository.user(id);
  }
}
