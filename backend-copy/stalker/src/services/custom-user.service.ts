// Copyright IBM Corp. and LoopBack contributors 2020. All Rights Reserved.
// Node module: @loopback/authentication-jwt
// This file is licensed under the MIT License.
// License text available at https://opensource.org/licenses/MIT

import {repository} from '@loopback/repository';
import {HttpErrors} from '@loopback/rest';
import {compare} from 'bcryptjs';
import {User, UserWithRelations} from '../models';
import {MyUserRepository} from '../repositories';
import {UserProfile, securityId} from '../types';
import {UserService} from './custom-user.service-interface';

/**
 * A pre-defined type for user credentials. It assumes a user logs in
 * using the email and password. You can modify it if your app has different credential fields
 */
export type Credentials = {
  username: string;
  password: string;
};

export class MyUserService implements UserService<User, Credentials> {
  constructor(
    @repository(MyUserRepository) public userRepository: MyUserRepository,
  ) { }

  async verifyCredentials(credentials: Credentials): Promise<User> {
    const invalidCredentialsError = 'Invalid username or password.';

    const foundUser = await this.userRepository.findOne({
      where: {username: credentials.username},
    });
    if (!foundUser) {
      throw new HttpErrors.Unauthorized(invalidCredentialsError);
    }

    const credentialsFound = await this.userRepository.findCredentials(
      foundUser.id,
    );
    if (!credentialsFound) {
      throw new HttpErrors.Unauthorized(invalidCredentialsError);
    }

    const passwordMatched = await compare(
      credentials.password,
      credentialsFound.password,
    );

    if (!passwordMatched) {
      throw new HttpErrors.Unauthorized(invalidCredentialsError);
    }

    return foundUser;
  }


  convertToUserProfile(user: User): UserProfile {
    return {
      [securityId]: user.id?.toString() || '',
      id: user.id,
      firstname: user.firstname,
      lastname: user.lastname,
      username: user.username,
      phonenumber: user.phoneNr,
    };
  }

  //function to find user by id
  async findUserById(id: string): Promise<User & UserWithRelations> {
    const idNr = parseInt(id);
    const userNotfound = 'invalid User';
    const foundUser = await this.userRepository.findOne({
      where: {id: idNr},
    });

    if (!foundUser) {
      throw new HttpErrors.Unauthorized(userNotfound);
    }
    return foundUser;
  }
}
