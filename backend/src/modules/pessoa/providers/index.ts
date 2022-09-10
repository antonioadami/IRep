import { container } from 'tsyringe';

import IAuthProvider from './AuthProvider/IAuthProvider';
import CognitoProvider from './AuthProvider/implementations/CognitoProvider';

container.registerSingleton<IAuthProvider>('AuthProvider', CognitoProvider);
