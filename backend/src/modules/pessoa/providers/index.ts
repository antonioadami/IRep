import { container } from 'tsyringe';

import IHashProvider from './HashProvider/models/IHashProvider';
import BCryptHashProvider from './HashProvider/implementations/BCryptHashProvider';
import IAuthProvider from './AuthProvider/models/IAuthProvider';
import CognitoProvider from './AuthProvider/implementations/CognitoProvider';

container.registerSingleton<IHashProvider>('HashProvider', BCryptHashProvider);
container.registerSingleton<IAuthProvider>('AuthProvider', CognitoProvider);
