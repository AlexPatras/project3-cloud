// Copyright IBM Corp. and LoopBack contributors 2019. All Rights Reserved.
// Node module: @loopback/security
// This file is licensed under the MIT License.
// License text available at https://opensource.org/licenses/MIT
//import {Subject, UserProfile} from './types';
import {BindingKey, MetadataAccessor} from '@loopback/core';
import {Middleware} from '@loopback/rest';
//import {SecurityBindings} from '@loopback/security';
import {AuthenticationComponent} from './custom-authentication-component';
import {
  AuthenticateFn,
  AuthenticationMetadata,
  AuthenticationStrategy,
  RefreshTokenService,
  Subject,
  UserProfile,
  UserProfileFactory
} from './types';

import {User} from './models';
import {Credentials, TokenService, UserService} from './services';


/// -- start import security
/**
 * Binding keys for security related metadata
 */
export namespace SecurityBindings {
  /**
   * Binding key for subject
   */
  export const SUBJECT = BindingKey.create<Subject>('security.subject');

  /**
   * Binding key for current user profile
   */
  export const USER = BindingKey.create<UserProfile>('security.user');
}


//---- end import security
/// -- start import authentiocation

/**
 * Binding keys used by this component.
 */
export namespace AuthenticationBindings {
  export const COMPONENT = BindingKey.create<AuthenticationComponent>(
    'components.AuthenticationComponent',
  );

  /**
   * Key used to bind a user profile factory to the context for any
   * consumer to use when they need to convert a user object
   * into a slimmer user profile object
   *
   * @example
   * ```ts
   * server
   *   .bind(AuthenticationBindings.USER_PROFILE_FACTORY)
   *   .to(myUserProfileFactory);
   * ```
   */
  /* eslint-disable @typescript-eslint/no-explicit-any */
  export const USER_PROFILE_FACTORY = BindingKey.create<
    UserProfileFactory<any>
  >('authentication.userProfileFactory');

  /**
   * Key used to bind an authentication strategy or multiple strategies
   * to the context for the authentication function to use.
   *
   * @example
   * ```ts
   * server
   *   .bind(AuthenticationBindings.STRATEGY)
   *   .toProvider(MyAuthenticationStrategy);
   * ```
   */
  export const STRATEGY = BindingKey.create<
    AuthenticationStrategy | AuthenticationStrategy[] | undefined
  >('authentication.strategy');

  /**
   * Key used to inject the authentication function into the sequence.
   *
   * @example
   * ```ts
   * class MySequence implements SequenceHandler {
   *   constructor(
   *     @inject(AuthenticationBindings.AUTH_ACTION)
   *     protected authenticateRequest: AuthenticateFn,
   *     // ... other sequence action injections
   *   ) {}
   *
   *   async handle(context: RequestContext) {
   *     try {
   *       const {request, response} = context;
   *       const route = this.findRoute(request);
   *
   *      // Authenticate
   *       await this.authenticateRequest(request);
   *
   *       // Authentication successful, proceed to invoke controller
   *       const args = await this.parseParams(request, route);
   *       const result = await this.invoke(route, args);
   *       this.send(response, result);
   *     } catch (err) {
   *       this.reject(context, err);
   *     }
   *   }
   * }
   * ```
   */
  export const AUTH_ACTION = BindingKey.create<AuthenticateFn>(
    'authentication.actions.authenticate',
  );

  /**
   * Binding key for AUTHENTICATION_MIDDLEWARE
   */
  export const AUTHENTICATION_MIDDLEWARE = BindingKey.create<Middleware>(
    'middleware.authentication',
  );

  /**
   * Key used to inject authentication metadata, which is used to determine
   * whether a request requires authentication or not.
   *
   * @example
   * ```ts
   * class MyPassportStrategyProvider implements Provider<Strategy | undefined> {
   *   constructor(
   *     @inject(AuthenticationBindings.METADATA)
   *     private metadata?: AuthenticationMetadata[],
   *   ) {}
   *   value(): ValueOrPromise<Strategy | undefined> {
   *     if (this.metadata?.length) {
   *       // logic to determine which authentication strategy to return
   *     }
   *   }
   * }
   * ```
   */
  export const METADATA = BindingKey.create<
    AuthenticationMetadata[] | undefined
  >('authentication.operationMetadata');

  export const AUTHENTICATION_STRATEGY_EXTENSION_POINT_NAME =
    'authentication.strategies';

  // Make `CURRENT_USER` the alias of SecurityBindings.USER for backward compatibility
  export const CURRENT_USER: BindingKey<UserProfile> = SecurityBindings.USER;

  // Redirect url for authenticating current user
  export const AUTHENTICATION_REDIRECT_URL = BindingKey.create<string>(
    'authentication.redirect.url',
  );

  // Authentication redirect status, usually 302 or 303, indicates a web client will redirect
  export const AUTHENTICATION_REDIRECT_STATUS = BindingKey.create<number>(
    'authentication.redirect.status',
  );
}

/**
 * The key used to store method-level metadata for `@authenticate`
 */
export const AUTHENTICATION_METADATA_METHOD_KEY = MetadataAccessor.create<
  AuthenticationMetadata,
  MethodDecorator
>('authentication:method');

/**
 * Alias for AUTHENTICATION_METADATA_METHOD_KEY to keep it backward compatible
 */
export const AUTHENTICATION_METADATA_KEY = AUTHENTICATION_METADATA_METHOD_KEY;

/**
 * The key used to store class-level metadata for `@authenticate`
 */
export const AUTHENTICATION_METADATA_CLASS_KEY = MetadataAccessor.create<
  AuthenticationMetadata,
  ClassDecorator
>('authentication:class');


// -- end import authentication
// -- start import jwt authentication




export namespace TokenServiceConstants {
  export const TOKEN_SECRET_VALUE = 'myjwts3cr3t';
  export const TOKEN_EXPIRES_IN_VALUE = '21600';
}

export namespace TokenServiceBindings {
  export const TOKEN_SECRET = BindingKey.create<string>(
    'authentication.jwt.secret',
  );
  export const TOKEN_EXPIRES_IN = BindingKey.create<string>(
    'authentication.jwt.expires.in.seconds',
  );
  export const TOKEN_SERVICE = BindingKey.create<TokenService>(
    'services.authentication.jwt.tokenservice',
  );
}

export namespace UserServiceBindings {
  export const USER_SERVICE = BindingKey.create<UserService<User, Credentials>>(
    'services.user.service',
  );
  export const DATASOURCE_NAME = 'jwtdb';
  export const USER_REPOSITORY = 'repositories.UserRepository';
  export const USER_CREDENTIALS_REPOSITORY =
    'repositories.UserCredentialsRepository';
}

/**
 * Constant values used when generating refresh token.
 */
export namespace RefreshTokenConstants {
  /**
   * The default secret used when generating refresh token.
   */
  export const REFRESH_SECRET_VALUE = 'r3fr35htok3n';
  /**
   * The default expiration time for refresh token.
   */
  export const REFRESH_EXPIRES_IN_VALUE = '216000';
  /**
   * The default issuer used when generating refresh token.
   */
  export const REFRESH_ISSUER_VALUE = 'loopback4';
}

/**
 * Bindings related to token refresh service. The omitted explanation can be
 * found in namespace `RefreshTokenConstants`.
 */
export namespace RefreshTokenServiceBindings {
  export const REFRESH_TOKEN_SERVICE = BindingKey.create<RefreshTokenService>(
    'services.authentication.jwt.refresh.tokenservice',
  );
  export const REFRESH_SECRET = BindingKey.create<string>(
    'authentication.jwt.refresh.secret',
  );
  export const REFRESH_EXPIRES_IN = BindingKey.create<string>(
    'authentication.jwt.refresh.expires.in.seconds',
  );
  export const REFRESH_ISSUER = BindingKey.create<string>(
    'authentication.jwt.refresh.issuer',
  );
  /**
   * The backend datasource for refresh token's persistency.
   */
  export const DATASOURCE_NAME = 'refreshdb';
  /**
   * Key for the repository that stores the refresh token and its bound user
   * information
   */
  export const REFRESH_REPOSITORY = 'repositories.RefreshTokenRepository';
}
//--- end import jwt authentication

