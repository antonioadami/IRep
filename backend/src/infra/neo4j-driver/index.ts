import neo4j from 'neo4j-driver';
import AppError from '../http/errors/AppError';

if (
    !process.env.NEO4J_URL ||
    !process.env.NEO4J_USER ||
    !process.env.NEO4J_PASSWORD
) {
    throw new AppError('Forneça a autenticação do Neo4j');
}

const driver = neo4j.driver(
    process.env.NEO4J_URL,
    neo4j.auth.basic(process.env.NEO4J_USER, process.env.NEO4J_PASSWORD),
);
const session = driver.session();
export default session;
