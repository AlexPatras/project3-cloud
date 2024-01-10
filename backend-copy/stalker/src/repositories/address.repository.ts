import {Getter, inject} from '@loopback/core';
import {BelongsToAccessor, DefaultCrudRepository, repository} from '@loopback/repository';
import {DbDataSource} from '../datasources';
import {Address, AddressRelations, User} from '../models';
import {MyUserRepository} from './user.repository';

export class AddressRepository extends DefaultCrudRepository<
  Address,
  typeof Address.prototype.id,
  AddressRelations
> {

  public readonly user: BelongsToAccessor<User, typeof Address.prototype.id>;

  constructor(
    @inject('datasources.db') dataSource: DbDataSource, @repository.getter('UserRepository') protected userRepositoryGetter: Getter<MyUserRepository>,
  ) {
    super(Address, dataSource);
    this.user = this.createBelongsToAccessorFor('user', userRepositoryGetter,);
    this.registerInclusionResolver('user', this.user.inclusionResolver);
  }
}
