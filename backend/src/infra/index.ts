import 'dotenv/config';
import 'reflect-metadata';
import 'express-async-errors';

import express, { NextFunction, Request, Response } from 'express';
import cors from 'cors';

import AppError from './http/errors/AppError';
import routes from './http/routes';
import './container';

const app = express();

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(routes);

app.use((err: Error, request: Request, response: Response, _: NextFunction) => {
    if (err instanceof AppError) {
        return response.status(err.statusCode).json({
            status: 'error',
            message: err.message,
        });
    }

    // eslint-disable-next-line no-console
    console.log(err);

    return response.status(500).json({
        status: 'error',
        message: 'Internal server error',
    });
});

app.listen(3333, () => {
    // eslint-disable-next-line no-console
    console.log('Servidor rodando na porta 3333');
});
