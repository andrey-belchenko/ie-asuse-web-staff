import { Controller, Get, Post, Body } from '@nestjs/common';
import { AppService } from './app.service';
import { execQuery } from './query';

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get()
  getHello(): string {
    return this.appService.getHello();
  }

  @Post('query')
  async create(@Body() request: any):Promise<any> {
    const data = await  execQuery(request)
    return data;
  }
}
