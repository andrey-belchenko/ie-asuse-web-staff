import { Router } from 'express';
import { UserController } from '@controllers/users.controller';
import { CreateUserDto, UpdateUserDto } from '@dtos/users.dto';
import { Routes } from '@interfaces/routes.interface';
import { ValidationMiddleware } from '@middlewares/validation.middleware';
import { QueryController } from '@/controllers/query.controller';

export class QueryRoute implements Routes {
  public path = '/query';
  public router = Router();
  public query = new QueryController();

  constructor() {
    this.initializeRoutes();
  }

  private initializeRoutes() {
    this.router.get(`${this.path}`, this.query.execQuery);
  }
}
