import { ApolloServer } from '@apollo/server';
import { startStandaloneServer } from '@apollo/server/standalone';
import { typeDefs, Resolvers } from 'graphql-schema';

const resolvers: Resolvers = {
  Query: {
    currentTime: () => { return { currentTime: 0, }; },
    greeting: () => { return { message: "Not implemented" }; },
  },
};

const server = new ApolloServer({
  typeDefs,
  resolvers,
});

const { url } = await startStandaloneServer(server, {
  listen: { port: 8000 },
});

console.log(`Server ready at: ${url}`);
