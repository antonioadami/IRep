import { container } from 'tsyringe';

import IAuthProvider from './AuthProvider/models/IAuthProvider';
import CognitoProvider from './AuthProvider/implementations/CognitoProvider';

container.registerSingleton<IAuthProvider>('AuthProvider', CognitoProvider);
