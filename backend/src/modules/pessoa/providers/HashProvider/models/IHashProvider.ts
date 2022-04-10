export default interface IHashProvider {
    generateHash(payload: string): Promise<string>;
    verify(payload: string, hashed: string): Promise<boolean>;
}
