import {Entity, belongsTo, hasMany, hasOne, model, property} from '@loopback/repository';
import {Address} from './address.model';
import {UserCredentials} from './custom-credentials.model';
import {StalkerList} from './stalker-list.model';


@model()
export class User extends Entity {
  @property({
    type: 'number',
    id: true,
    generated: true,
  })
  id?: number;

  @property({
    type: 'string',
    required: true,
  })
  firstname: string;

  @property({
    type: 'string',
    required: true,
  })
  lastname: string;

  @property({
    type: 'string',
    required: true,
  })
  username: string;

  @property({
    type: 'string',
    required: true,
  })
  password: string;

  @property({
    type: 'string',
    required: true,
  })
  phoneNr: string;

  @hasMany(() => Address)
  addresses: Address[];

  constructor(data?: Partial<User>) {
    super(data);
  }

  @belongsTo(() => StalkerList)
  stalkerListId: number;

  @hasOne(() => UserCredentials)
  userCredentials: UserCredentials;
}

export interface UserRelations {
  // describe navigational properties here
}

export type UserWithRelations = User & UserRelations;
