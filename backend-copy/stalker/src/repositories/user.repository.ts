import {Getter, inject} from '@loopback/core';
import {DefaultCrudRepository, HasManyRepositoryFactory, HasOneRepositoryFactory, repository} from '@loopback/repository';
import {DbDataSource} from '../datasources';
import {Address, User, UserCredentials, UserRelations} from '../models';
import {AddressRepository} from './address.repository';
import {UserCredentialsRepository} from './custom-credentials.repository';


export class MyUserRepository extends DefaultCrudRepository<
  User,
  typeof User.prototype.id,
  UserRelations
> {

  public readonly userCredentials: HasOneRepositoryFactory<
    UserCredentials,
    typeof User.prototype.id
  >;
  public readonly addresses: HasManyRepositoryFactory<Address, typeof User.prototype.id>;

  constructor(
    @inject('datasources.db') dataSource: DbDataSource,
    @repository.getter('AddressRepository') protected addressRepositoryGetter: Getter<AddressRepository>,
    @repository.getter('UserCredentialsRepository') protected userCredentialsRepositoryGetter: Getter<UserCredentialsRepository>,

  ) {
    super(User, dataSource);
    this.addresses = this.createHasManyRepositoryFactoryFor('addresses', addressRepositoryGetter,);
    this.registerInclusionResolver('addresses', this.addresses.inclusionResolver);
    this.userCredentials = this.createHasOneRepositoryFactoryFor(
      'userCredentials',
      userCredentialsRepositoryGetter,
    );
    this.registerInclusionResolver(
      'userCredentials',
      this.userCredentials.inclusionResolver,
    );
  }
  async findCredentials(
    userId: typeof User.prototype.id,
  ): Promise<UserCredentials | undefined> {
    return this.userCredentials(userId)
      .get()
      .catch(err => {
        if (err.code === 'ENTITY_NOT_FOUND') return undefined;
        throw err;
      });

  }
}
