import {
  Count,
  CountSchema,
  Filter,
  FilterExcludingWhere,
  repository,
  Where,
} from '@loopback/repository';
import {
  post,
  param,
  get,
  getModelSchemaRef,
  patch,
  put,
  del,
  requestBody,
  response,
} from '@loopback/rest';
import {StalkerList} from '../models';
import {StalkerListRepository} from '../repositories';

export class StalkerListController {
  constructor(
    @repository(StalkerListRepository)
    public stalkerListRepository : StalkerListRepository,
  ) {}

  @post('/stalker-lists')
  @response(200, {
    description: 'StalkerList model instance',
    content: {'application/json': {schema: getModelSchemaRef(StalkerList)}},
  })
  async create(
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(StalkerList, {
            title: 'NewStalkerList',
            exclude: ['id'],
          }),
        },
      },
    })
    stalkerList: Omit<StalkerList, 'id'>,
  ): Promise<StalkerList> {
    return this.stalkerListRepository.create(stalkerList);
  }

  @get('/stalker-lists/count')
  @response(200, {
    description: 'StalkerList model count',
    content: {'application/json': {schema: CountSchema}},
  })
  async count(
    @param.where(StalkerList) where?: Where<StalkerList>,
  ): Promise<Count> {
    return this.stalkerListRepository.count(where);
  }

  @get('/stalker-lists')
  @response(200, {
    description: 'Array of StalkerList model instances',
    content: {
      'application/json': {
        schema: {
          type: 'array',
          items: getModelSchemaRef(StalkerList, {includeRelations: true}),
        },
      },
    },
  })
  async find(
    @param.filter(StalkerList) filter?: Filter<StalkerList>,
  ): Promise<StalkerList[]> {
    return this.stalkerListRepository.find(filter);
  }

  @patch('/stalker-lists')
  @response(200, {
    description: 'StalkerList PATCH success count',
    content: {'application/json': {schema: CountSchema}},
  })
  async updateAll(
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(StalkerList, {partial: true}),
        },
      },
    })
    stalkerList: StalkerList,
    @param.where(StalkerList) where?: Where<StalkerList>,
  ): Promise<Count> {
    return this.stalkerListRepository.updateAll(stalkerList, where);
  }

  @get('/stalker-lists/{id}')
  @response(200, {
    description: 'StalkerList model instance',
    content: {
      'application/json': {
        schema: getModelSchemaRef(StalkerList, {includeRelations: true}),
      },
    },
  })
  async findById(
    @param.path.number('id') id: number,
    @param.filter(StalkerList, {exclude: 'where'}) filter?: FilterExcludingWhere<StalkerList>
  ): Promise<StalkerList> {
    return this.stalkerListRepository.findById(id, filter);
  }

  @patch('/stalker-lists/{id}')
  @response(204, {
    description: 'StalkerList PATCH success',
  })
  async updateById(
    @param.path.number('id') id: number,
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(StalkerList, {partial: true}),
        },
      },
    })
    stalkerList: StalkerList,
  ): Promise<void> {
    await this.stalkerListRepository.updateById(id, stalkerList);
  }

  @put('/stalker-lists/{id}')
  @response(204, {
    description: 'StalkerList PUT success',
  })
  async replaceById(
    @param.path.number('id') id: number,
    @requestBody() stalkerList: StalkerList,
  ): Promise<void> {
    await this.stalkerListRepository.replaceById(id, stalkerList);
  }

  @del('/stalker-lists/{id}')
  @response(204, {
    description: 'StalkerList DELETE success',
  })
  async deleteById(@param.path.number('id') id: number): Promise<void> {
    await this.stalkerListRepository.deleteById(id);
  }
}
