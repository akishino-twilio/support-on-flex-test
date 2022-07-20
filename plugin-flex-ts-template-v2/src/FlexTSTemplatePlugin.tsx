import * as Flex from '@twilio/flex-ui';
import { FlexPlugin } from '@twilio/flex-plugin';

import AddReducers from './flex-hooks/redux';
import ConfigureFlexStrings from './flex-hooks/strings';
import CustomizeFlexComponents from './flex-hooks/components';
import CustomizeFlexActions from './flex-hooks/actions';
import RegisterCustomChannels from './flex-hooks/channels';
import RegisterFlexNotifications from './flex-hooks/notifications';
import CreateSdkClientInstances from './flex-hooks/sdk-clients';
import TeamFilters from './flex-hooks/teams-filters/TeamFilters';
import CustomChatOrchestration from './flex-hooks/chat-orchestrator';
import SalesForceHooks from './flex-hooks/iframe-hooks'
import cssoverrides from './flex-hooks/css-overrides'

const PLUGIN_NAME = 'FlexTSTemplatePlugin';

export default class FlexTSTemplatePlugin extends FlexPlugin {
  constructor() {
    super(PLUGIN_NAME);
  }

  /**
   * This code is run when your plugin is being started
   * Use this to modify any UI components or attach to the actions framework
   *
   * @param flex { typeof Flex }
   * @param manager { Flex.Manager }
   */
  init(flex: typeof Flex, manager: Flex.Manager) {
    const initializers = [
      AddReducers,
      ConfigureFlexStrings,
      RegisterCustomChannels,
      RegisterFlexNotifications,
      CustomizeFlexActions,
      CustomizeFlexComponents,
      CreateSdkClientInstances,
      TeamFilters,
      CustomChatOrchestration,
      SalesForceHooks,
      cssoverrides
    ];

    initializers.forEach((initializer) => initializer(flex, manager));
  }
}
