import { NextFunction, Request, Response } from 'express';
import { Container } from 'typedi';
import { User } from '@interfaces/users.interface';
import { UserService } from '@services/users.service';

export class QueryController {
  public user = Container.get(UserService);

  public execQuery = async (req: Request, res: Response, next: NextFunction): Promise<void> => {
    try {
      res.status(200).json({ data: "yep" });
    } catch (error) {
      next(error);
    }
  };
}
