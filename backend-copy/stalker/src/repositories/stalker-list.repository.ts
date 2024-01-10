import {Getter, inject} from '@loopback/core';
import {DefaultCrudRepository, HasManyRepositoryFactory, repository} from '@loopback/repository';
import {DbDataSource} from '../datasources';
import {StalkerList, StalkerListRelations, User} from '../models';
import {MyUserRepository} from './user.repository';

export class StalkerListRepository extends DefaultCrudRepository<
  StalkerList,
  typeof StalkerList.prototype.id,
  StalkerListRelations
> {

  public readonly users: HasManyRepositoryFactory<User, typeof StalkerList.prototype.id>;

  constructor(
    @inject('datasources.db') dataSource: DbDataSource, @repository.getter('UserRepository') protected userRepositoryGetter: Getter<MyUserRepository>,
  ) {
    super(StalkerList, dataSource);
    this.users = this.createHasManyRepositoryFactoryFor('users', userRepositoryGetter,);
    this.registerInclusionResolver('users', this.users.inclusionResolver);
  }
}
