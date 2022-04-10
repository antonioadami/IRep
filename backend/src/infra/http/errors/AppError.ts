class AppError {
    constructor(public message: string, public statusCode = 400) {}
}

export default AppError;
